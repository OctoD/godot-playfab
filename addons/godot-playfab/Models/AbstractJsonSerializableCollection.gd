# This is a wrapper class around an Array
extends JsonSerializable
class_name AbstractJsonSerializableCollection


# Holds the items
var _Items: Array


# Appends an element at the end of the array (alias of push_back).
func append(item: JsonSerializable):
	_Items.append(item)


# Returns the number of elements in the array.
func size() -> int:
	return _Items.size()

# Clears the array. This is equivalent to using resize with a size of 0.
func clear():
	_Items.clear();


## MASSIVE HACK 😬
# Casts this collection and sub-objects to an Array of Dictionaries, recursively.
# The method name is only `to_dict` to keep the API compatible with `JsonSerializable`
# The return value is an ARRAY! The type hint is also just there to keep API compatible
func to_dict() -> Dictionary:
	var index = 0
	var dict = []	# Actually, Array of items! It'S called dict because
	for item in _Items:
		dict.append((item as JsonSerializable).to_dict())
		index += 1

	return dict


# Rehydrates a collection and appropriate sub-objects from a Dictionary, recursively
func from_dict(data: Dictionary, instance: JsonSerializable):
	var index = 0
	for item in data:
		_Items.append(.from_dict(item, instance))
		index += 1