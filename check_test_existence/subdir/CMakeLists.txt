add_test(NAME my_test2 COMMAND ${CMAKE_COMMAND} -E echo "Hello test from subfolder")

check_for_test(my_test2)