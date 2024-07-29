extends Resource
class_name Wave 

const WaveInfo = preload("res://Scripts/wave_info.gd")
const WAVE_TIME = 5.0
var wave_chunks: Array[WaveInfo] = []
