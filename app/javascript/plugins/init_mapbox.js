import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import { initWordCloud } from './init_word_cloud';


const initMapbox = () => {

  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/jsuay/ckwgaz6fn05aj14lhe45rxbck',
      center: [20.673147, 30.599413],
      zoom: 1.3,
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    // const counters = JSON.stringify(mapElement.dataset.counters);
    // console.log(counters);



    addMarkersToMap(map, markers);
    // console.log(markers);
    // addClusters(map, markers, counters);
  }

};


const addMarkersToMap = (map, markers) => {


  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window);
    // add event listener for the popup
    popup.on('open', () => {
      console.log('popup was opened');
      const popupElement = popup.getElement();

      const canvas = popupElement.querySelector('.word-cloud-canvas')
      initWordCloud(canvas)
      const pop = document.querySelector('.mapboxgl-popup.mapboxgl-popup-anchor-top')
      // pop.style.maxWidth = "900px";
      // pop.style.height = "300px";
      pop.style.fontFamily = "Inconsolata, monospace";

      // const pubOne =
      // const pubTwo =


      // add button in markers
      const btnAdd = popupElement.querySelector('.input-map-add');
      const compBtn = document.querySelector('.javi-compare-button')
      // input publisher one
      const optOne = document.getElementById('comparison_publisher_one');
      const optTwo = document.getElementById('comparison_publisher_two')
      const showBlock = document.querySelector('.javi-block')

      btnAdd.addEventListener("click", (event) => {
        event.preventDefault()
        const sourceName = document.getElementById('popup-header').innerText


        if (optOne.value == "") {
          optOne.value = sourceName
          set_source(optOne)
          // optOne.style.zIndex = "10";
          // optOne.style.backgroundColor = "white";
          // optOne.style.maxWidth = "200px";
          // optOne.style.borderRadius = "18px";
          // optOne.style.textAlign = "center";

        } else if (optOne.value != "" && optTwo.value == "") {
          optTwo.value = sourceName
          set_source(optTwo)
          // optTwo.style.display = "block";
          // optTwo.style.zIndex = "10";
          // optTwo.style.backgroundColor = "white";
          // // showBlock.style.opacity = "1";
        }

      });
      const set_source = (element) =>{
        element.style.position = "relative";
        element.style.display = "block";
        element.style.zIndex = "10";
        element.style.backgroundColor = "white";
        element.style.borderRadius = "18px";
        element.style.textAlign = "center";
      }
    });

    const element = document.createElement('div');
    element.classList.add("markerStyling");
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundRepeat = 'no-repeat';
    element.style.borderRadius = '50px';
    element.style.backgroundColor = 'white';
    element.style.backgroundSize = 'contain';
    element.style.width = '50px';
    element.style.height = '50px';

    // Create a HTML element for your custom marker


    // const popup = new mapboxgl.Popup().setHTML(marker.info_window); // add this

    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup) // add this
      .addTo(map);
  });




};



// CLUSTERS

// const addClusters = (map, markers, counters) => {

//   // console.log(counters);

//   const features = markers.map((marker) => {

//     return {
//       "type": "Feature",
//       "geometry": {
//         "type": "Point",
//         "coordinates": [marker.lng, marker.lat]
//       }
//     }
//   })


//   const source = {
//     "type": "geojson",
//     "data": {
//       "type": "FeatureCollection",
//       "features": features
//     },
//     cluster: true,
//     clusterMaxZoom: 14, // Max zoom to cluster points on
//     clusterRadius: 50 // Radius of each cluster when clustering points (defaults to 50)
//   }

//   map.on('load', () => {
//     // Add a new source from our GeoJSON data and
//       // set the 'cluster' option to true. GL-JS will
//       // add the point_count property to your source data.
//       map.addSource('articles', source);

//       map.addLayer({
//         id: 'clusters',
//         type: 'circle',
//         source: 'articles',
//         filter: ['has', 'point_count'],
//         paint: {
//           // Use step expressions (https://docs.mapbox.com/mapbox-gl-js/style-spec/#expressions-step)
//           // with three steps to implement three types of circles:
//           //   * Blue, 20px circles when point count is less than 100
//           //   * Yellow, 30px circles when point count is between 100 and 750
//           //   * Pink, 40px circles when point count is greater than or equal to 750
//           'circle-color': [
//             'step',
//             ['get', 'point_count'],
//             '#51bbd6',
//             100,
//             '#f1f075',
//             750,
//             '#f28cb1'
//           ],
//           'circle-radius': [
//             'step',
//             ['get', 'point_count'],
//             20,
//             100,
//             30,
//             750,
//             40
//           ]
//         }
//       });


//       map.addLayer({
//         id: 'cluster-count',
//         type: 'symbol',
//         source: 'articles',
//         filter: ['has', 'point_count'],
//         layout: {
//           'text-field': '{point_count_abbreviated}',
//           'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
//           'text-size': 12
//         }
//       });

//       map.addLayer({
//         id: 'unclustered-point',
//         type: 'circle',
//         source: 'articles',
//         filter: ['!', ['has', 'point_count']],
//         paint: {
//           'circle-color': '#11b4da',
//           'circle-radius': 4,
//           'circle-stroke-width': 1,
//           'circle-stroke-color': '#fff'
//         }
//       });

//       // inspect a cluster on click
//       map.on('click', 'clusters', (e) => {
//         const features = map.queryRenderedFeatures(e.point, {
//           layers: ['clusters']
//         });
//         const clusterId = features[0].properties.cluster_id;
//         map.getSource('earthquakes').getClusterExpansionZoom(
//           clusterId,
//           (err, zoom) => {
//             if (err) return;

//             map.easeTo({
//               center: features[0].geometry.coordinates,
//               zoom: zoom
//             });
//           }
//         );
//       });

//       // When a click event occurs on a feature in
//       // the unclustered-point layer, open a popup at
//       // the location of the feature, with
//       // description HTML from its properties.
//       map.on('click', 'unclustered-point', (e) => {
//         const coordinates = e.features[0].geometry.coordinates.slice();
//         const mag = e.features[0].properties.mag;
//         const tsunami =
//           e.features[0].properties.tsunami === 1 ? 'yes' : 'no';

//         // Ensure that if the map is zoomed out such that
//         // multiple copies of the feature are visible, the
//         // popup appears over the copy being pointed to.
//         while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
//           coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
//         }

//         new mapboxgl.Popup()
//           .setLngLat(coordinates)
//           .setHTML(
//             `magnitude: ${mag}<br>Was there a tsunami?: ${tsunami}`
//           )
//           .addTo(map);
//       });

//       map.on('mouseenter', 'clusters', () => {
//         map.getCanvas().style.cursor = 'pointer';
//       });
//       map.on('mouseleave', 'clusters', () => {
//         map.getCanvas().style.cursor = '';
//       });

//   });

// }



export { initMapbox };
