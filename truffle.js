module.exports = {
  networks: {
    miranet: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      from: "0x0024803dc78BF948458735dB6a1D5D4CE79cD417"
    },
    development: {
      host: "127.0.0.1",
      port: 9545,
      network_id: "*"
    },
  }
};
