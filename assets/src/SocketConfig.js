import { Socket as PhxSocket } from 'phoenix';

class SocketConfig {
	constructor() {
		this.socket = null;
	}

	static getSocket() {
		return this.socket;
	}

	static initSocket() {
		this.socket = new PhxSocket('/socket');
		this.socket.connect();
	}

	static disconnectSocket() {
		if (this.socket) {
			this.socket.disconnect();
		}
	}

	static getChannel(topic) {
		if (this.socket) {
			return this.socket.channel(topic);
		}
	}
}

export default SocketConfig;
