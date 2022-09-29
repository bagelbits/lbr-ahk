#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

FindViolin() {
  graphicsearch_query := "|<Violin>0xC68862@1.00$2.y"
  resultObj := graphicsearch.search(graphicsearch_query)
  if (resultObj) {
    X := resultObj.1.x, Y := resultObj.1.y
    DelayedClick(X, Y, 0)
    resultObj := ""
  }
  return
}
