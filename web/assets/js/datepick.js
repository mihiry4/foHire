from_picker = from_$input.pickadate('picker');
to_picker = to_$input.pickadate('picker');
from_picker.set('min', true);


// Check if there’s a “from” or “to” date to start with.
if (from_picker.get('value')) {
    to_picker.set('min', from_picker.get('select'));


}
if (to_picker.get('value')) {
    from_picker.set('max', to_picker.get('select'))
}

// When something is selected, update the “from” and “to” limits.
from_picker.on('set', function (event) {
    if (event.select) {
        var dis = from_picker.get('disable');
        to_picker.set('min', from_picker.get('select'));
        for (var i = 0; i < dis.length; i++) {
            console.log(dis[i][2]);
            console.log(from_picker.get('select').date);
            if (dis[i][2] > from_picker.get('select').date) {
                to_picker.set('max', dis[i]);
                break;
            }
            else {
                to_picker.set('max', false);
            }
        }

    }
    else if ('clear' in event) {
        to_picker.set('min', false);
        to_picker.set('max', false);
    }
})
to_picker.on('set', function (event) {
    if (event.select) {
        //from_picker.set('max', to_picker.get('select'))
    }
    else if ('clear' in event) {
        from_picker.set('max', false)
    }
})