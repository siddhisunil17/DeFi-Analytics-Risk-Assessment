-- 1) Staging table (raw CSV load target)
CREATE TABLE staging_deploy (
    block_hash      VARCHAR(100),
    block_number    INT,
    block_timestamp TIMESTAMP,
    transaction_hash VARCHAR(100),
    transaction_index INT,
    event_index     INT,
    from_address    VARCHAR(100),
    to_address      VARCHAR(100),
    token_id        VARCHAR(100),
    quantity        NUMERIC,
    event_type      VARCHAR(50)
);

-- 2) Block
CREATE TABLE Block (
    block_number    INT          PRIMARY KEY,
    block_hash      VARCHAR(100) NOT NULL UNIQUE,
    block_timestamp TIMESTAMP    NOT NULL,
    miner_info      VARCHAR(100)
);

-- 3) Wallet
CREATE TABLE Wallet (
    wallet_address  VARCHAR(100) PRIMARY KEY
);

-- 4) Token
CREATE TABLE Token (
    token_id     VARCHAR(100) PRIMARY KEY,
    token_symbol VARCHAR(50),
    decimals     INT
);

-- 5) Transaction
CREATE TABLE "Transaction" (
    transaction_hash  VARCHAR(100) PRIMARY KEY,
    transaction_index INT          NOT NULL,
    block_number      INT          NOT NULL,
    from_wallet       VARCHAR(100) NOT NULL,
    to_wallet         VARCHAR(100) NOT NULL,
    CONSTRAINT fk_tx_block
      FOREIGN KEY(block_number)
      REFERENCES Block(block_number)
      ON DELETE RESTRICT,
    CONSTRAINT fk_tx_from_wallet
      FOREIGN KEY(from_wallet)
      REFERENCES Wallet(wallet_address)
      ON DELETE RESTRICT,
    CONSTRAINT fk_tx_to_wallet
      FOREIGN KEY(to_wallet)
      REFERENCES Wallet(wallet_address)
      ON DELETE RESTRICT
);

-- 6) TokenEvent
CREATE TABLE TokenEvent (
    transaction_hash VARCHAR(100) NOT NULL,
    event_index      INT          NOT NULL,
    quantity         NUMERIC      NOT NULL CHECK (quantity >= 0),
    event_type       VARCHAR(50)  NOT NULL,
    token_id         VARCHAR(100),
    to_wallet        VARCHAR(100),
    PRIMARY KEY (transaction_hash, event_index),
    CONSTRAINT fk_te_txn
      FOREIGN KEY(transaction_hash)
      REFERENCES "Transaction"(transaction_hash)
      ON DELETE CASCADE,
    CONSTRAINT fk_te_token
      FOREIGN KEY(token_id)
      REFERENCES Token(token_id)
      ON DELETE SET NULL,
    CONSTRAINT fk_te_wallet
      FOREIGN KEY(to_wallet)
      REFERENCES Wallet(wallet_address)
      ON DELETE SET NULL
);

-- 7) Indexes for performance
CREATE INDEX idx_txn_block_number  ON "Transaction"(block_number);
CREATE INDEX idx_txn_from_wallet   ON "Transaction"(from_wallet);
CREATE INDEX idx_txn_to_wallet     ON "Transaction"(to_wallet);
CREATE INDEX idx_te_token_id       ON TokenEvent(token_id);
CREATE INDEX idx_te_to_wallet      ON TokenEvent(to_wallet);
CREATE INDEX idx_te_txn_event      ON TokenEvent(transaction_hash, event_index);
