import SocketConfig from './SocketConfig';

/* Contains basic methods for initializing and tearing down channels connections */
class BaseChannel {
    constructor(channelName) {
        this.channel = null;
        this.channelName = channelName;
    }

    init() {
        return new Promise((resolve, reject) => {
            this.channel = SocketConfig.getChannel(this.channelName);

            this.channel
                .join()
                .receive('ok', (r) => {
                    console.debug('ok: ', r);
                    resolve(r);
                })
                .receive('error', (error) => {
                    reject(console.error(`${this.channelName} join failed`, error));
                })
                .receive('timeout', () => reject(console.error(`${this.channelName} timeout`)));
        });
    }

    disconnect() {
        if (this.channel) {
            this.channel.leave();
        }
    }

    isInitialized() {
        return this.channel?.state === 'joined';
    }

    push(topic, params) {
        return new Promise((resolve, reject) => {
            this.channel
                .push(topic, params)
                .receive('ok', (r) => {
                    resolve(r);
                })
                .receive('error', (resp) => {
                    console.error(`${topic} error`, params, resp);
                    reject(resp);
                })
                .receive('timeout', () => {
                    console.error(`${topic} timeout`, params);
                    reject();
                });
        });
    }
}

export default BaseChannel;
