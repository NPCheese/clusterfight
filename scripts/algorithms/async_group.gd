class_name AsyncGroup
extends Node

## Designed for keeping track of multiple anonymous tasks and emitting 
## a signal when all of the tasks are completed.

signal tasks_completed

var _finished_tasks: int = 0: set = _on_set_finished_tasks

var _required_tasks: int = 0: set = _on_set_required_tasks

func submit(n_tasks: int=1) -> void:
	_finished_tasks += n_tasks

func require(n_tasks: int=1) -> void:
	_required_tasks += n_tasks

func _validate() -> void:
	if _tasks_finished():
		tasks_completed.emit()

func _tasks_finished() -> bool:
	return _finished_tasks >= _required_tasks

func _on_set_finished_tasks(new_val: int) -> void:
	_finished_tasks = new_val
	_validate()

func _on_set_required_tasks(new_val: int) -> void:
	_required_tasks = new_val
	_validate()

func _init(n_tasks) -> void:
	_required_tasks = n_tasks
