import BaseChannel from './BaseChannel';

class RushingChannel extends BaseChannel {
    listen(topic, callback) {
        this.channel.on(topic, (data) => {
            callback(data);
        });
    }
}

export default RushingChannel;
