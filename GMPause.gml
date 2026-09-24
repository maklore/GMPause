/**
 * A small pause manager.
 * @returns {struct.GMPause}
 */
function GMPause(){
    
	static paused = false;
    static pause_list = [];
	static pause_count = 0;
    
    /**
     * Add instance or object id to a pause list.
     * @param {id.Instance} _id Instance or object ID.
     */
    static add = function(_id) {
        if !struct_exists(_id, "object_index") or 
           !instance_exists(_id) or 
           array_contains(pause_list, _id) { 
            return false;
        }
        array_push(pause_list, _id);
        return true;
    }
    
    /**
     * Pause all instances and objects in the list.
     */
    static enable = function() {
		pause_count++;
		if paused { exit; }
        __clear_nonexistant();
        paused = true;

    }    
    
    /**
     * Unpause all instances and objects in the list.
     */
    static disable = function() {
		pause_count--;
        if pause_count > 0 { exit; }
        __reactivate_instances();
		paused = false;
    }
    
    /**
     * Add to pre draw event.
     * Reactivates all instances and objects in the list.
     */
    static event_pre_draw = function() {
        if !paused { exit; }
        __reactivate_instances();
    }

    /**
     * Add to post draw event.
     * Deactivates all instances and objects in the list.
     */
    static event_post_draw = function() {
        if !paused { exit; }
		__deactivate_instances();
    }    
    
	/**
	 * Add to room end event.
	 * Clear list on room end.
	 */
	static event_room_end = function() {
		pause_list = [];
	}
	
	
	/// @ignore
	static __reactivate_instances = function() {
        var _length = array_length(pause_list);
        for (var i = 0; i < _length; ++i;) {
            var _instance = pause_list[i];
            instance_activate_object(_instance);
        }	
	}
	
	/// @ignore
	static __deactivate_instances = function() {
        var _length = array_length(pause_list);
        for (var i = 0; i < _length; ++i;) {
            var _instance = pause_list[i];
            if instance_exists(_instance) {
                instance_deactivate_object(_instance);
            }
        }
	}
	
    /// @ignore
    static __clear_nonexistant = function() {
        var _length = array_length(pause_list);
        for (var i = 0; i < _length; ++i;) {
            var _instance = pause_list[i];
            if !instance_exists(_instance) {
                array_delete(pause_list, i, 1);
				_length--;
            }
        }
    }
    
    return static_get(GMPause);
    
}

GMPause();
