class_name DrawZone
extends Node

@onready var comp_split_pile: ComponentDrawZoneSplitPile = $CompSplitPile

@onready var piles_group: CanvasGroup = $PilesGroup

@onready var top_pile: Pile = $PilesGroup/TopPile
@onready var top_button: DrawZoneButton = $PilesGroup/TopPile/TopButton

@onready var bottom_button: DrawZoneButton = $PilesGroup/BottomPile/BottomButton
@onready var bottom_pile: Pile = $PilesGroup/BottomPile
