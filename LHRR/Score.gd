extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Ennemis tués : " + str(get_parent().score) + "\nEnnemis restants : " + str(get_parent().remaining_enemies)
