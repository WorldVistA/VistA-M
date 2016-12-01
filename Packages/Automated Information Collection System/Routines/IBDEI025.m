IBDEI025 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2329,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,2329,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,2330,0)
 ;;=M51.14^^12^161^8
 ;;^UTILITY(U,$J,358.3,2330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2330,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2330,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,2330,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,2331,0)
 ;;=M51.15^^12^161^9
 ;;^UTILITY(U,$J,358.3,2331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2331,1,3,0)
 ;;=3^Intvrt disc disorders w/ radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2331,1,4,0)
 ;;=4^M51.15
 ;;^UTILITY(U,$J,358.3,2331,2)
 ;;=^5012244
 ;;^UTILITY(U,$J,358.3,2332,0)
 ;;=M54.6^^12^161^10
 ;;^UTILITY(U,$J,358.3,2332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2332,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,2332,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,2332,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,2333,0)
 ;;=M51.44^^12^161^11
 ;;^UTILITY(U,$J,358.3,2333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2333,1,3,0)
 ;;=3^Schmorl's nodes, thoracic region
 ;;^UTILITY(U,$J,358.3,2333,1,4,0)
 ;;=4^M51.44
 ;;^UTILITY(U,$J,358.3,2333,2)
 ;;=^5012255
 ;;^UTILITY(U,$J,358.3,2334,0)
 ;;=M99.02^^12^161^12
 ;;^UTILITY(U,$J,358.3,2334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2334,1,3,0)
 ;;=3^Segmental and somatic dysfunction of thoracic region
 ;;^UTILITY(U,$J,358.3,2334,1,4,0)
 ;;=4^M99.02
 ;;^UTILITY(U,$J,358.3,2334,2)
 ;;=^5015402
 ;;^UTILITY(U,$J,358.3,2335,0)
 ;;=M47.814^^12^161^13
 ;;^UTILITY(U,$J,358.3,2335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2335,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2335,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,2335,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,2336,0)
 ;;=S23.9XXS^^12^161^14
 ;;^UTILITY(U,$J,358.3,2336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2336,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, sequela
 ;;^UTILITY(U,$J,358.3,2336,1,4,0)
 ;;=4^S23.9XXS
 ;;^UTILITY(U,$J,358.3,2336,2)
 ;;=^5023269
 ;;^UTILITY(U,$J,358.3,2337,0)
 ;;=S23.9XXD^^12^161^15
 ;;^UTILITY(U,$J,358.3,2337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2337,1,3,0)
 ;;=3^Sprain of unspecified parts of thorax, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2337,1,4,0)
 ;;=4^S23.9XXD
 ;;^UTILITY(U,$J,358.3,2337,2)
 ;;=^5023268
 ;;^UTILITY(U,$J,358.3,2338,0)
 ;;=G54.3^^12^161^16
 ;;^UTILITY(U,$J,358.3,2338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2338,1,3,0)
 ;;=3^Thoracic root disorders, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,2338,1,4,0)
 ;;=4^G54.3
 ;;^UTILITY(U,$J,358.3,2338,2)
 ;;=^5004010
 ;;^UTILITY(U,$J,358.3,2339,0)
 ;;=M99.83^^12^162^1
 ;;^UTILITY(U,$J,358.3,2339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2339,1,3,0)
 ;;=3^Biomechanical lesions of lumbar region
 ;;^UTILITY(U,$J,358.3,2339,1,4,0)
 ;;=4^M99.83
 ;;^UTILITY(U,$J,358.3,2339,2)
 ;;=^5015483
 ;;^UTILITY(U,$J,358.3,2340,0)
 ;;=M51.36^^12^162^2
 ;;^UTILITY(U,$J,358.3,2340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2340,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbar region
 ;;^UTILITY(U,$J,358.3,2340,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,2340,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,2341,0)
 ;;=M51.37^^12^162^3
 ;;^UTILITY(U,$J,358.3,2341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2341,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2341,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,2341,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,2342,0)
 ;;=M51.06^^12^162^4
 ;;^UTILITY(U,$J,358.3,2342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2342,1,3,0)
 ;;=3^Intervertebral disc disorders w/ myelopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2342,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,2342,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,2343,0)
 ;;=M51.16^^12^162^5
 ;;^UTILITY(U,$J,358.3,2343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2343,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2343,1,4,0)
 ;;=4^M51.16
 ;;^UTILITY(U,$J,358.3,2343,2)
 ;;=^5012245
 ;;^UTILITY(U,$J,358.3,2344,0)
 ;;=M51.17^^12^162^6
 ;;^UTILITY(U,$J,358.3,2344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2344,1,3,0)
 ;;=3^Intervertebral disc disorders w/ radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2344,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,2344,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,2345,0)
 ;;=M54.5^^12^162^8
 ;;^UTILITY(U,$J,358.3,2345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2345,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,2345,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,2345,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,2346,0)
 ;;=G54.1^^12^162^9
 ;;^UTILITY(U,$J,358.3,2346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2346,1,3,0)
 ;;=3^Lumbosacral plexus disorders
 ;;^UTILITY(U,$J,358.3,2346,1,4,0)
 ;;=4^G54.1
 ;;^UTILITY(U,$J,358.3,2346,2)
 ;;=^5004008
 ;;^UTILITY(U,$J,358.3,2347,0)
 ;;=G54.4^^12^162^10
 ;;^UTILITY(U,$J,358.3,2347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2347,1,3,0)
 ;;=3^Lumbosacral root disorders NEC
 ;;^UTILITY(U,$J,358.3,2347,1,4,0)
 ;;=4^G54.4
 ;;^UTILITY(U,$J,358.3,2347,2)
 ;;=^5004011
 ;;^UTILITY(U,$J,358.3,2348,0)
 ;;=M54.16^^12^162^11
 ;;^UTILITY(U,$J,358.3,2348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2348,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2348,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,2348,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,2349,0)
 ;;=M54.17^^12^162^12
 ;;^UTILITY(U,$J,358.3,2349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2349,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2349,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,2349,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,2350,0)
 ;;=M51.46^^12^162^13
 ;;^UTILITY(U,$J,358.3,2350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2350,1,3,0)
 ;;=3^Schmorl's nodes, lumbar region
 ;;^UTILITY(U,$J,358.3,2350,1,4,0)
 ;;=4^M51.46
 ;;^UTILITY(U,$J,358.3,2350,2)
 ;;=^5012257
 ;;^UTILITY(U,$J,358.3,2351,0)
 ;;=M99.03^^12^162^14
 ;;^UTILITY(U,$J,358.3,2351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2351,1,3,0)
 ;;=3^Segmental and somatic dysfunction of lumbar region
 ;;^UTILITY(U,$J,358.3,2351,1,4,0)
 ;;=4^M99.03
 ;;^UTILITY(U,$J,358.3,2351,2)
 ;;=^5015403
 ;;^UTILITY(U,$J,358.3,2352,0)
 ;;=M48.06^^12^162^15
 ;;^UTILITY(U,$J,358.3,2352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2352,1,3,0)
 ;;=3^Spinal stenosis, lumbar region
 ;;^UTILITY(U,$J,358.3,2352,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,2352,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,2353,0)
 ;;=S33.5XXA^^12^162^17
 ;;^UTILITY(U,$J,358.3,2353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2353,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,2353,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,2353,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,2354,0)
 ;;=S33.5XXS^^12^162^18
 ;;^UTILITY(U,$J,358.3,2354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2354,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,2354,1,4,0)
 ;;=4^S33.5XXS
 ;;^UTILITY(U,$J,358.3,2354,2)
 ;;=^5025174
 ;;^UTILITY(U,$J,358.3,2355,0)
 ;;=S33.5XXD^^12^162^19
 ;;^UTILITY(U,$J,358.3,2355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2355,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2355,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,2355,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,2356,0)
 ;;=M43.16^^12^162^16
 ;;^UTILITY(U,$J,358.3,2356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2356,1,3,0)
 ;;=3^Spondylolisthesis, lumbar region
 ;;^UTILITY(U,$J,358.3,2356,1,4,0)
 ;;=4^M43.16
 ;;^UTILITY(U,$J,358.3,2356,2)
 ;;=^5011927
 ;;^UTILITY(U,$J,358.3,2357,0)
 ;;=M51.26^^12^162^7
 ;;^UTILITY(U,$J,358.3,2357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2357,1,3,0)
 ;;=3^Intervrtbrl Disc Displacement,Lumbar
 ;;^UTILITY(U,$J,358.3,2357,1,4,0)
 ;;=4^M51.26
 ;;^UTILITY(U,$J,358.3,2357,2)
 ;;=^5012249
 ;;^UTILITY(U,$J,358.3,2358,0)
 ;;=M99.85^^12^163^1
 ;;^UTILITY(U,$J,358.3,2358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2358,1,3,0)
 ;;=3^Biomechanical lesions of pelvic region
 ;;^UTILITY(U,$J,358.3,2358,1,4,0)
 ;;=4^M99.85
 ;;^UTILITY(U,$J,358.3,2358,2)
 ;;=^5015485
 ;;^UTILITY(U,$J,358.3,2359,0)
 ;;=M99.84^^12^163^2
 ;;^UTILITY(U,$J,358.3,2359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2359,1,3,0)
 ;;=3^Biomechanical lesions of sacral region
 ;;^UTILITY(U,$J,358.3,2359,1,4,0)
 ;;=4^M99.84
 ;;^UTILITY(U,$J,358.3,2359,2)
 ;;=^5015484
 ;;^UTILITY(U,$J,358.3,2360,0)
 ;;=G54.0^^12^163^3
 ;;^UTILITY(U,$J,358.3,2360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2360,1,3,0)
 ;;=3^Brachial plexus disorders
 ;;^UTILITY(U,$J,358.3,2360,1,4,0)
 ;;=4^G54.0
 ;;^UTILITY(U,$J,358.3,2360,2)
 ;;=^5004007
 ;;^UTILITY(U,$J,358.3,2361,0)
 ;;=M76.02^^12^163^4
 ;;^UTILITY(U,$J,358.3,2361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2361,1,3,0)
 ;;=3^Gluteal tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,2361,1,4,0)
 ;;=4^M76.02
 ;;^UTILITY(U,$J,358.3,2361,2)
 ;;=^5013268
 ;;^UTILITY(U,$J,358.3,2362,0)
 ;;=M76.01^^12^163^5
 ;;^UTILITY(U,$J,358.3,2362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2362,1,3,0)
 ;;=3^Gluteal tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,2362,1,4,0)
 ;;=4^M76.01
 ;;^UTILITY(U,$J,358.3,2362,2)
 ;;=^5013267
 ;;^UTILITY(U,$J,358.3,2363,0)
 ;;=M76.22^^12^163^6
 ;;^UTILITY(U,$J,358.3,2363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2363,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,2363,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,2363,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,2364,0)
 ;;=M76.21^^12^163^7
 ;;^UTILITY(U,$J,358.3,2364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2364,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,2364,1,4,0)
 ;;=4^M76.21
