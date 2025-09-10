# Returning Referenced Data
- A function that returns an immutable reference should have the following name: <type>_ref. This symbolizes that a reference to that object is being returned
- A function that returns a mutable reference should have the following name: as_<type>. This symbolizes how the function "converts" it to the new type.
- A function that returns a copy of its underlying data should have the following name: generate_<type>. This symbolizes how a new object is being created that reflects itself
