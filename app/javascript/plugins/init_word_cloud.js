import WordCloud from 'wordcloud'


const initWordCloud = (canvas) => {
  const list = JSON.parse(canvas.dataset.words)
  console.log(list)
  WordCloud(canvas, { list: list,
                      fontFamily: 'Montserrat, monospace',
                      backgroundColor: 'black',
                      fontWeight: '600',
                      weightFactor: '7',
                      color: 'white',
                      rotationSteps: '2',
                      shrinkToFit: true,

                    });
}

export { initWordCloud };
