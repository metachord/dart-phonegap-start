//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, May 24, 2012 12:05:08 PM
// Author: tomyeh
part of rikulo_event;

/**
 * An event to indicate a view's value has been changed.
 * It is sent with [ViewEvents.change].
 */
class ChangeEvent<T> extends ViewEvent {
  final T _value;
  ChangeEvent(T value, [String type="change", View target]):
  super(type, target), _value = value;

  /** Returns the value.
   */
  T get value => _value;

  String toString() => "ChangeEvent($target,$value)";
}
