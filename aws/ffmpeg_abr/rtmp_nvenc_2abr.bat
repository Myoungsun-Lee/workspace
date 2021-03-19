ffmpeg -stream_loop -1 -i "udp://@localhost:50001?overrun_nonfatal=1&fifo_size=50000000" -filter_complex "[0:v]split=2[v1][v2]; [v1]copy[v1out]; [v2]copy[v2out]" ^
-map [v1out] -c:v:0 h264_nvenc -gpu 1 -b:v:0 18M -cbr true -bufsize:v:0 20M -preset fast -g 30 ^
-map [v2out] -c:v:1 h264_nvenc -gpu 1 -b:v:1 10M -cbr true -bufsize:v:1 15M -preset fast -g 30 ^
-map a:0 -c:a:0 aac -b:a:0 320k -map a:0 -c:a:1 aac -b:a:1 320k -f ^
hls -hls_flags delete_segments -hls_init_time 4 -hls_time 4 -hls_list_size 15 -hls_segment_type mpegts -hls_segment_filename channel_%%v_%%d.ts -master_pl_name channel.m3u8 -var_stream_map "v:0,a:0 v:1,a:1" channel_%%v.m3u8