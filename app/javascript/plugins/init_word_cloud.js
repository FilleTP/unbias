import WordCloud from 'wordcloud'


const initWordCloud = (canvas) => {
  const list = JSON.parse(canvas.dataset.words)
  console.log(list)
  WordCloud(canvas, { list: list, fontFamily: 'Montserrat, monospace', fontWeight: '600', weightFactor: '7', color: 'black', rotationSteps: '2' });
}

export { initWordCloud };
