package cicd.apk

default deny = false

max_bytes := input.max_apk_bytes
apk := input.report.apk_debug.bytes

deny if {
  apk != null
  max_bytes != null
  apk > max_bytes
}
