enum Passed {
  good,
  bad,
  flat,
}

String passedJudgement(Passed pass) {
  if (pass == Passed.good) {
    return 'OK';
  } else if (pass == Passed.bad) {
    return 'NG';
  } else if (pass == Passed.flat) {
    return 'FLAT';
  } else {
    return 'PassedConstantクラスでerror';
  }
}
