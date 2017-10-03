## Plan to test the top up method

- create an instance of OysterCard class, oyster
- call top_up method on the object oyster
- this will produce a MethodError that there is no method called 'top_up'

## Plan to test maximum balance

- create an instance of the OysterCard class, oyster
- decide on a maximum value, let's say 90
- call top_up method on oyster, of a value of 91
- this should produce a RuntimeError saying 'This is above maximum balance!'
