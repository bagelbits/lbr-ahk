FindAndUseViolin() {
  graphicsearch_query := "|<Violin>0xC68862@1.00$2.y"
  resultObj := graphicsearch.search(graphicsearch_query)
  if (resultObj) {
    X := resultObj.1.x, Y := resultObj.1.y
    DelayedClick(X, Y, 0)
    resultObj := ""
  }
  DelayedSend(hotKeys.artifacts.violin)
  return
}

SpamArtifacts(artifactsToSpam) {
  for k, v in artifactsToSpam {
    DelayedSend(hotKeys.artifacts[v])
  }
}
