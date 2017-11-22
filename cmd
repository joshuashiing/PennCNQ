#!/bin/bash

# Cluster events
./bin/preprocess/cluster_events --src data/catalogs/OK_2014-2015-2016.csv --dst data/EvN --n_components 1 --model KMeans

# Create event windows
./bin/preprocess/create_dataset_events.py --stream_dir data/streams --catalog data/EvN/catalog_with_cluster_ids.csv --output_dir data/EvN/EWin --save_mseed True --plot True

# Create noise windows
./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_2-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 10000 --save_mseed True --output_dir data/EvN/NWin_GSOK029_2014_02_10000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_3-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 10000 --save_mseed True --output_dir data/EvN/NWin_GSOK029_2014_03_10000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_4-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 10000 --save_mseed True --output_dir data/EvN/NWin_GSOK029_2014_04_10000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_5-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 10000 --save_mseed True --output_dir data/EvN/NWin_GSOK029_2014_05_10000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_6-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 10000 --save_mseed True --output_dir data/EvN/NWin_GSOK029_2014_06_10000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_8-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 10000 --save_mseed True --output_dir data/EvN/NWin_GSOK029_2014_08_10000

# Set up test sets
./bin/preprocess/create_dataset_events.py --stream_dir data/test_streams --catalog data/EvN/catalog_with_cluster_ids.csv --output_dir data/EvN/test_set/EWin --save_mseed True --plot True

./bin/preprocess/create_dataset_noise.py --stream_path data/test_streams/GSOK029_7-2014.mseed --catalog data/catalogs/Benz_catalog.csv --max_windows 50000 --save_mseed True --output_dir data/EvN/test_set/NWin_GSOK029_2014_07_50000 --plot True

# Train
./bin/train --dataset data/EvN/train --checkpoint_dir data/EvN/model --n_clusters 1

# Convert stream to tfrecords
./bin/preprocess/convert_stream_to_tfrecords.py --stream_path data/test_streams/GSOK027_7-2014.mseed --output_dir  data/EvN/cont_stream/GSOK027/tfrecords --window_size 10 --window_step 11

./bin/preprocess/convert_stream_to_tfrecords.py --stream_path data/test_streams/GSOK029_7-2014.mseed --output_dir  data/EvN/cont_stream/GSOK029/tfrecords --window_size 10 --window_step 11

# Predict from tfrecords
./bin/predict_from_tfrecords.py --dataset data/EvN/cont_stream/GSOK029/tfrecords --checkpoint_dir data/EvN/model/convnetquake --n_clusters 1 --output data/EvN/cont_stream/GSOK029/prediction
