./bin/preprocess/cluster_events --src data/catalogs/OK_2014-2015-2016.csv --dst data/EvN --n_components 1 --model KMeans

./bin/preprocess/create_dataset_events.py --stream_dir data/streams --catalog data/EvN/catalog_with_cluster_ids.csv --output_dir data/EvN/EWin --save_mseed True --plot True

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_8-2014.mseed --catalog data/catalogs/Benz_catalog.csv --output_dir --max_windows 5000 --save_mseed True data/EvN/NWin_GSOK029_2014_08_5000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_6-2014.mseed --catalog data/catalogs/Benz_catalog.csv --output_dir --max_windows 5000 --save_mseed True data/EvN/NWin_GSOK029_2014_06_5000

./bin/preprocess/create_dataset_noise.py --stream_path data/streams/GSOK029_4-2014.mseed --catalog data/catalogs/Benz_catalog.csv --output_dir --max_windows 5000 --save_mseed True data/EvN/NWin_GSOK029_2014_04_5000
