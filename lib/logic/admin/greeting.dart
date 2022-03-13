String greetingMessage(){

  var timeNow = DateTime.now().hour;
  
  if (timeNow < 12) {
    return 'Goedemorgen';
  } else if ((timeNow >= 12) && (timeNow <= 16)) {
  return 'Goedemiddag';
  } else if ((timeNow > 16) && (timeNow < 22)) {
  return 'Goedeavond';
  } else {
  return 'Goedenacht';
  }
}