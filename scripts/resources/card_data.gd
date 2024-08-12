class_name CardData
extends Resource

@export var cardName: String
@export_multiline var shortDescription: String
@export var rating: int
@export var cardClass: GameCards.CardClass = GameCards.CardClass.ACTION

@export var artworkVariants: Array[Texture2D] = []
@export var titleLogo: Texture2D

@export var highlightColor: GameCards.CardColor = GameCards.CardColor.WHITE

@export var countPerPlayers: Array[int] = [0, 0, 0, 0, 0, 0, 0]

@export var flags: Array[GameCards.CardFlags] = []
