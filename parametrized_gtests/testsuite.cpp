#include <gtest/gtest.h>

// Simple test

TEST(SimpleTestsuite, SimpleTest) { SUCCEED(); }

// TypeParametrizedTestsuite

template <typename T>
class TypeParametrizedTestsuite : public ::testing::Test {};
TYPED_TEST_SUITE_P(TypeParametrizedTestsuite);
TYPED_TEST_P(TypeParametrizedTestsuite, TypeTest) { SUCCEED(); }
REGISTER_TYPED_TEST_SUITE_P(TypeParametrizedTestsuite, TypeTest);
using MyTypes = ::testing::Types<char, int, unsigned int>;
INSTANTIATE_TYPED_TEST_SUITE_P(TypePrefix, TypeParametrizedTestsuite, MyTypes);

// TypeParametrizedTestsuiteCollision

template <typename T>
class TypeParametrizedTestsuiteCollision : public ::testing::Test {};
TYPED_TEST_SUITE_P(TypeParametrizedTestsuiteCollision);
TYPED_TEST_P(TypeParametrizedTestsuiteCollision, TypeTest) { SUCCEED(); }
REGISTER_TYPED_TEST_SUITE_P(TypeParametrizedTestsuiteCollision, TypeTest);
INSTANTIATE_TYPED_TEST_SUITE_P(TypePrefix, TypeParametrizedTestsuiteCollision, MyTypes);

// ValueParameterizedTestSuite

class ValueParameterizedTestSuite : public testing::TestWithParam<int> {};
TEST_P(ValueParameterizedTestSuite, ValueTest) { SUCCEED(); }
INSTANTIATE_TEST_SUITE_P(ValuePrefix, ValueParameterizedTestSuite,
                         testing::Values(1, 2, 3));
