const semver = require('semver');

a = semver.satisfies('2.0.0', '1 - 2');
b = semver.satisfies('2.1.0', '1 - 2');
c = semver.satisfies('3.0.0', '1 - 2');

console.log(a); // true
console.log(b); // true
console.log(c); // false
