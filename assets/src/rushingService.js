import RushingChannel from './RushingChannel';

export const RUSH_CHANNEL = 'rushing';

const rushingChannel = new RushingChannel(RUSH_CHANNEL);

export const initRushingChannel = async () => {
    if (rushingChannel.isInitialized()) {
        return;
    }

    await rushingChannel.init();
    return rushingChannel;
};

export const disconnectRushingChannel = async () => {
    rushingChannel.disconnect();
};


export const sortPlayers = (params) => {
    rushingChannel.push("sort", params);
};