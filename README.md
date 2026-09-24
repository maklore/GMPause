<h1 align="center">GMPause</h1>
<h4 align="center">A small pause manager.</h4>

<br></br>
When objects/instances are paused, the only events active are between pre- and post-draw events.
> Based on PixelatedPope's pause [tutorial](https://www.youtube.com/watch?v=8OeSMgBSau4).
## Basic setup
- Create a script in GameMaker.
- Copy code from [GMPause.gml](https://github.com/maklore/GMPause/blob/main/GMPause.gml) and paste to script.

- Add to any object's create event you want to be paused.
  ```gml
  GMPause.add(id);
  ```
  
- Create a persistent object to be a pause manager.
  
- Step event
  ```gml
  if keyboard_check_released(vk_esc) {
  	if !GMPause.paused { 
  		GMPause.enable();
  	} else {
  		GMPause.disable();
  	}
  }
  ```
- Pre-Draw event
  ```gml
  GMPause.event_pre_draw();
  ```

- Post-Draw event
  ```gml
  GMPause.event_post_draw();
  ```

- Room end event
  ```gml
  GMPause.event_room_end();
  ```

- Have fun!
