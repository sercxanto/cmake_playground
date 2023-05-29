
# Does fail:
#file(STRINGS /nonexistent.txt content)
#file(MD5 "." content)

# Does not fail
file(STRINGS "${nonexistent}" content)
message("content: '${content}'")

file(STRINGS "" content)
message("content: '${content}'")

file(STRINGS "/" content)
message("content: '${content}'")

file(STRINGS "." content)
message("content: '${content}'")

file(READ "" content)
message("content: '${content}'")

file(READ "/" content)
message("content: '${content}'")

file(READ "." content)
message("content: '${content}'")
