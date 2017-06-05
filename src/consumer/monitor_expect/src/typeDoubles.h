#ifndef TYPEDOUBLES_H
#define TYPEDOUBLES_H


struct sfail
{
  unsigned int _callcount;
  float _return;
  float _expect;
  unsigned int _time;
  unsigned int _delay;
};
typedef sfail tfail;

#endif
