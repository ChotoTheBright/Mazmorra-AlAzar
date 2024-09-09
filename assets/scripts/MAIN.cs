using Godot;
using System;

public partial class MAIN : Node
{
	private PackedScene _playerScene;
	private PackedScene _flrTile;
	private WorldEnvironment _env;

	public override void _Ready()
	{
		_playerScene = ResourceLoader.Load<PackedScene>("res://Player.tscn");
		_flrTile = ResourceLoader.Load<PackedScene>("res://Tile.tscn");
		_env = GetNode<WorldEnvironment>("WorldEnvironment");

		spawn_player();
	}

	private void spawn_player()
	{
		var inst = _playerScene.Instantiate();
		//GD.Print("whats happenin' here?");
		AddChild(inst);

	}

	private void spawn_grid()
	{

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}
}
