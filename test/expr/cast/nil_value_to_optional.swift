// RUN: %target-parse-verify-swift

var t = true
var f = false

func markUsed<T>(_ t: T) {}

markUsed(t != nil) // expected-warning {{comparing non-optional value to nil always returns true}}
markUsed(f != nil) // expected-warning {{comparing non-optional value to nil always returns true}}

class C : Equatable {}

func == (lhs: C, rhs: C) -> Bool {
  return true
}

func test(_ c: C) {
  if c == nil {}  // expected-warning {{comparing non-optional value to nil always returns false}}
}

class D {}

var d = D()
var dopt: D? = nil
var diuopt: D! = nil

_ = d! // expected-error {{cannot force unwrap value of non-optional type 'D'}}
_ = dopt == nil
_ = diuopt == nil
