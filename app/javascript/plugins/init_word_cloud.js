import WordCloud from 'wordcloud'

const initWordCloud = (canvas) => {
  const list = JSON.parse(canvas.dataset.words)
  console.log(list)
  WordCloud(canvas, { list: list, fontWeight: '600', weightFactor: '20', color: 'random-dark', rotationSteps: '2', fontSize: '5'});
}

export { initWordCloud };
