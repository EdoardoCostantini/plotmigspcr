app <- ShinyDriver$new("../../")
app$snapshotInit("module-1-inputs")

app$snapshot()
app$setInputs(next_vairable = "click")
app$setInputs(variable = "v3")
