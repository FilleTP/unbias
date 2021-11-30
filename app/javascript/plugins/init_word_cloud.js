import WordCloud from 'wordcloud'

const initWordCloud = () => {
  const canvas = document.getElementById('my_canvas');
  if (canvas) {
    const list = JSON.parse(canvas.dataset.words)
    WordCloud(canvas, {
      list: list, fontFamily: 'Montserrat, monospace', fontWeight: '600', weightFactor: '7', color: 'black', rotationSteps: '2' });
  }
}

export { initWordCloud };

// '#000000 #404040 #7f7f7f #bfbfbf'
