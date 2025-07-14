-- Bulk‐load the full 10K-row CSV into staging:
COPY staging_deploy
  FROM :'DATA_DIR'/cleaned_ethereum_events_10000.csv
  WITH (FORMAT csv, HEADER true);


-- 2. Populate Block
INSERT INTO Block (block_number, block_hash, block_timestamp, miner_info)
SELECT DISTINCT 
  block_number, 
  block_hash, 
  block_timestamp,
  NULL AS miner_info
FROM staging_deploy
ON CONFLICT DO NOTHING;


-- 3. Populate Wallet
INSERT INTO Wallet (wallet_address)
SELECT DISTINCT from_address
FROM staging_deploy
UNION
SELECT DISTINCT to_address
FROM staging_deploy
ON CONFLICT DO NOTHING;



-- 4. Populate Token
INSERT INTO Token (token_id, token_symbol, decimals)
SELECT DISTINCT
  token_id,
  NULL::VARCHAR(50)  AS token_symbol,
  NULL::INT          AS decimals
FROM staging_deploy
WHERE token_id IS NOT NULL
ON CONFLICT DO NOTHING;



-- 5. Populate Transaction (one row per unique transaction)
INSERT INTO "Transaction" (
  transaction_hash,
  transaction_index,
  block_number,
  from_wallet,
  to_wallet
)
SELECT DISTINCT ON (transaction_hash)
  transaction_hash,
  transaction_index,
  block_number,
  from_address,
  to_address
FROM staging_deploy
ORDER BY transaction_hash, event_index
ON CONFLICT DO NOTHING;

-- 6. Populate TokenEvent (one row per event)
INSERT INTO TokenEvent (
  transaction_hash,
  event_index,
  quantity,
  event_type,
  token_id,
  to_wallet
)
SELECT
  transaction_hash,
  event_index,
  quantity,
  event_type,
  token_id,
  to_address
FROM staging_deploy
ON CONFLICT DO NOTHING;
