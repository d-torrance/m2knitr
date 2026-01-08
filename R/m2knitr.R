eng_m2 <- function(options) {
  cmd <- knitr:::get_engine_path(options$engine.path, options$engine, "M2")
  opts <- knitr:::get_engine_opts(options$engine.opts, options$engine)
  m2file <- tempfile(fileext = ".m2")
  writeLines(options$code, m2file)
  out <- system2(
    cmd,
    args = c("--silent", "--no-prompts", "-e", "'echoOff()'", opts),
    stdin = m2file,
    stdout = TRUE,
    stderr = TRUE,
    env = options$engine.env
  )
  unlink(m2file)
  knitr::engine_output(options, options$code, out)
}

knitr::knit_engines$set(m2 = eng_m2)
knitr::knit_engines$set(macaulay2 = eng_m2)
