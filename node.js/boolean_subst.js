var x;  console.log(x);
// undefined
if (x !== null) { console.log("true"); } else {console.log("false"); }
// true
if (x != null) { console.log("true"); } else {console.log("false"); }
// false
if (x) { console.log("true"); } else {console.log("false"); }
// false

x = null;  console.log(x);
// null
if (x !== null) { console.log("true"); } else {console.log("false"); }
// false
if (x != null) { console.log("true"); } else {console.log("false"); }
// false
if (x) { console.log("true"); } else {console.log("false"); }
// false

x = 'a string';  console.log(x);
// 'a string'
if (x !== null) { console.log("true"); } else {console.log("false"); }
// true
if (x != null) { console.log("true"); } else {console.log("false"); }
// true
if (x) { console.log("true"); } else {console.log("false"); }
// true

