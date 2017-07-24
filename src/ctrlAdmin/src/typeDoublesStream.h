#ifndef TYPEDOUBLESSTREAM_H
#define TYPEDOUBLESSTREAM_H


struct sfailure
{
  unsigned int _callcount;
  float _return;
  float _expect;
  unsigned int _time;
  unsigned int _delay;
};
typedef sfailure tfailure;

#endif
