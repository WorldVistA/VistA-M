IBDEI00Z ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1849,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,1849,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,1849,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,1850,0)
 ;;=E11.22^^16^126^67
 ;;^UTILITY(U,$J,358.3,1850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1850,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,1850,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,1850,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,1851,0)
 ;;=E11.29^^16^126^85
 ;;^UTILITY(U,$J,358.3,1851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1851,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,1851,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,1851,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,1852,0)
 ;;=E11.311^^16^126^118
 ;;^UTILITY(U,$J,358.3,1852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1852,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,1852,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,1852,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,1853,0)
 ;;=E11.319^^16^126^119
 ;;^UTILITY(U,$J,358.3,1853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1853,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,1853,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,1853,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,1854,0)
 ;;=E11.36^^16^126^66
 ;;^UTILITY(U,$J,358.3,1854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1854,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,1854,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,1854,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,1855,0)
 ;;=E11.39^^16^126^87
 ;;^UTILITY(U,$J,358.3,1855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1855,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,1855,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,1855,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,1856,0)
 ;;=E11.40^^16^126^72
 ;;^UTILITY(U,$J,358.3,1856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1856,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,1856,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,1856,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,1857,0)
 ;;=E11.49^^16^126^86
 ;;^UTILITY(U,$J,358.3,1857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1857,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Diabetic Neurological Complication
 ;;^UTILITY(U,$J,358.3,1857,1,4,0)
 ;;=4^E11.49
 ;;^UTILITY(U,$J,358.3,1857,2)
 ;;=^5002649
 ;;^UTILITY(U,$J,358.3,1858,0)
 ;;=E11.41^^16^126^69
 ;;^UTILITY(U,$J,358.3,1858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1858,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,1858,1,4,0)
 ;;=4^E11.41
 ;;^UTILITY(U,$J,358.3,1858,2)
 ;;=^5002645
 ;;^UTILITY(U,$J,358.3,1859,0)
 ;;=E11.42^^16^126^74
 ;;^UTILITY(U,$J,358.3,1859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1859,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1859,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,1859,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,1860,0)
 ;;=E11.43^^16^126^65
 ;;^UTILITY(U,$J,358.3,1860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1860,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1860,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,1860,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,1861,0)
 ;;=E11.44^^16^126^64
 ;;^UTILITY(U,$J,358.3,1861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1861,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,1861,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,1861,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,1862,0)
 ;;=E11.51^^16^126^73
 ;;^UTILITY(U,$J,358.3,1862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1862,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,1862,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,1862,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,1863,0)
 ;;=E11.59^^16^126^83
 ;;^UTILITY(U,$J,358.3,1863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1863,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Circulatory Complications
 ;;^UTILITY(U,$J,358.3,1863,1,4,0)
 ;;=4^E11.59
 ;;^UTILITY(U,$J,358.3,1863,2)
 ;;=^5002652
 ;;^UTILITY(U,$J,358.3,1864,0)
 ;;=E11.610^^16^126^71
 ;;^UTILITY(U,$J,358.3,1864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1864,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,1864,1,4,0)
 ;;=4^E11.610
 ;;^UTILITY(U,$J,358.3,1864,2)
 ;;=^5002653
 ;;^UTILITY(U,$J,358.3,1865,0)
 ;;=E11.618^^16^126^84
 ;;^UTILITY(U,$J,358.3,1865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1865,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,1865,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,1865,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,1866,0)
 ;;=E11.620^^16^126^68
 ;;^UTILITY(U,$J,358.3,1866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1866,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,1866,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,1866,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,1867,0)
 ;;=E11.621^^16^126^75
 ;;^UTILITY(U,$J,358.3,1867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1867,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,1867,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,1867,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,1868,0)
 ;;=E11.622^^16^126^90
 ;;^UTILITY(U,$J,358.3,1868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1868,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Skin Ulcer
 ;;^UTILITY(U,$J,358.3,1868,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,1868,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,1869,0)
 ;;=E11.628^^16^126^89
 ;;^UTILITY(U,$J,358.3,1869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1869,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Skin Complications
 ;;^UTILITY(U,$J,358.3,1869,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,1869,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,1870,0)
 ;;=E11.630^^16^126^92
 ;;^UTILITY(U,$J,358.3,1870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1870,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,1870,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,1870,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,1871,0)
 ;;=E11.638^^16^126^88
 ;;^UTILITY(U,$J,358.3,1871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1871,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Oral Complications
 ;;^UTILITY(U,$J,358.3,1871,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,1871,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,1872,0)
 ;;=E11.69^^16^126^91
 ;;^UTILITY(U,$J,358.3,1872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1872,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Specified Complication
 ;;^UTILITY(U,$J,358.3,1872,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,1872,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,1873,0)
 ;;=E11.8^^16^126^117
 ;;^UTILITY(U,$J,358.3,1873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1873,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,1873,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,1873,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,1874,0)
 ;;=E10.3211^^16^126^19
 ;;^UTILITY(U,$J,358.3,1874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1874,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mld Nonprlf Diab Rtnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1874,1,4,0)
 ;;=4^E10.3211
 ;;^UTILITY(U,$J,358.3,1874,2)
 ;;=^5138279
 ;;^UTILITY(U,$J,358.3,1875,0)
 ;;=E10.3212^^16^126^20
 ;;^UTILITY(U,$J,358.3,1875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1875,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mld Nonprlf Diab Rtnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1875,1,4,0)
 ;;=4^E10.3212
 ;;^UTILITY(U,$J,358.3,1875,2)
 ;;=^5138280
 ;;^UTILITY(U,$J,358.3,1876,0)
 ;;=E10.3213^^16^126^21
 ;;^UTILITY(U,$J,358.3,1876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1876,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mld Nonprlf Diab Rtnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1876,1,4,0)
 ;;=4^E10.3213
 ;;^UTILITY(U,$J,358.3,1876,2)
 ;;=^5138281
 ;;^UTILITY(U,$J,358.3,1877,0)
 ;;=E10.3291^^16^126^22
 ;;^UTILITY(U,$J,358.3,1877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1877,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mld Nonprlf Diab Rtnop w/o Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1877,1,4,0)
 ;;=4^E10.3291
 ;;^UTILITY(U,$J,358.3,1877,2)
 ;;=^5138283
 ;;^UTILITY(U,$J,358.3,1878,0)
 ;;=E10.3292^^16^126^23
 ;;^UTILITY(U,$J,358.3,1878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1878,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mld Nonprlf Diab Rtnop w/o Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1878,1,4,0)
 ;;=4^E10.3292
 ;;^UTILITY(U,$J,358.3,1878,2)
 ;;=^5138284
 ;;^UTILITY(U,$J,358.3,1879,0)
 ;;=E10.3293^^16^126^24
 ;;^UTILITY(U,$J,358.3,1879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1879,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mld Nonprlf Diab Rtnop w/o Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1879,1,4,0)
 ;;=4^E10.3293
 ;;^UTILITY(U,$J,358.3,1879,2)
 ;;=^5138285
 ;;^UTILITY(U,$J,358.3,1880,0)
 ;;=E10.3311^^16^126^25
 ;;^UTILITY(U,$J,358.3,1880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1880,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Rtnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1880,1,4,0)
 ;;=4^E10.3311
 ;;^UTILITY(U,$J,358.3,1880,2)
 ;;=^5138287
 ;;^UTILITY(U,$J,358.3,1881,0)
 ;;=E10.3312^^16^126^26
 ;;^UTILITY(U,$J,358.3,1881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1881,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Rtnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1881,1,4,0)
 ;;=4^E10.3312
 ;;^UTILITY(U,$J,358.3,1881,2)
 ;;=^5138288
 ;;^UTILITY(U,$J,358.3,1882,0)
 ;;=E10.3313^^16^126^27
 ;;^UTILITY(U,$J,358.3,1882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1882,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Rtnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1882,1,4,0)
 ;;=4^E10.3313
 ;;^UTILITY(U,$J,358.3,1882,2)
 ;;=^5138289
 ;;^UTILITY(U,$J,358.3,1883,0)
 ;;=E10.3391^^16^126^28
 ;;^UTILITY(U,$J,358.3,1883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1883,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Rtnop w/o Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1883,1,4,0)
 ;;=4^E10.3391
 ;;^UTILITY(U,$J,358.3,1883,2)
 ;;=^5138291
 ;;^UTILITY(U,$J,358.3,1884,0)
 ;;=E10.3392^^16^126^29
 ;;^UTILITY(U,$J,358.3,1884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1884,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Rtnop w/o Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1884,1,4,0)
 ;;=4^E10.3392
 ;;^UTILITY(U,$J,358.3,1884,2)
 ;;=^5138292
 ;;^UTILITY(U,$J,358.3,1885,0)
 ;;=E10.3393^^16^126^30
 ;;^UTILITY(U,$J,358.3,1885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1885,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Rtnop w/o Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1885,1,4,0)
 ;;=4^E10.3393
 ;;^UTILITY(U,$J,358.3,1885,2)
 ;;=^5138293
 ;;^UTILITY(U,$J,358.3,1886,0)
 ;;=E10.3511^^16^126^41
 ;;^UTILITY(U,$J,358.3,1886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1886,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1886,1,4,0)
 ;;=4^E10.3511
 ;;^UTILITY(U,$J,358.3,1886,2)
 ;;=^5138303
 ;;^UTILITY(U,$J,358.3,1887,0)
 ;;=E10.3512^^16^126^42
 ;;^UTILITY(U,$J,358.3,1887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1887,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1887,1,4,0)
 ;;=4^E10.3512
 ;;^UTILITY(U,$J,358.3,1887,2)
 ;;=^5138304
 ;;^UTILITY(U,$J,358.3,1888,0)
 ;;=E10.3513^^16^126^43
 ;;^UTILITY(U,$J,358.3,1888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1888,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1888,1,4,0)
 ;;=4^E10.3513
 ;;^UTILITY(U,$J,358.3,1888,2)
 ;;=^5138305
 ;;^UTILITY(U,$J,358.3,1889,0)
 ;;=E10.3591^^16^126^44
 ;;^UTILITY(U,$J,358.3,1889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1889,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/o Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1889,1,4,0)
 ;;=4^E10.3591
 ;;^UTILITY(U,$J,358.3,1889,2)
 ;;=^5138323
 ;;^UTILITY(U,$J,358.3,1890,0)
 ;;=E10.3592^^16^126^45
 ;;^UTILITY(U,$J,358.3,1890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1890,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/o Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1890,1,4,0)
 ;;=4^E10.3592
 ;;^UTILITY(U,$J,358.3,1890,2)
 ;;=^5138324
 ;;^UTILITY(U,$J,358.3,1891,0)
 ;;=E10.3593^^16^126^46
 ;;^UTILITY(U,$J,358.3,1891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1891,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Rtnop w/o Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1891,1,4,0)
 ;;=4^E10.3593
 ;;^UTILITY(U,$J,358.3,1891,2)
 ;;=^5138325
 ;;^UTILITY(U,$J,358.3,1892,0)
 ;;=E10.3411^^16^126^53
 ;;^UTILITY(U,$J,358.3,1892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1892,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diab Rtnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1892,1,4,0)
 ;;=4^E10.3411
 ;;^UTILITY(U,$J,358.3,1892,2)
 ;;=^5138295
 ;;^UTILITY(U,$J,358.3,1893,0)
 ;;=E10.3412^^16^126^54
 ;;^UTILITY(U,$J,358.3,1893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1893,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diab Rtnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1893,1,4,0)
 ;;=4^E10.3412
 ;;^UTILITY(U,$J,358.3,1893,2)
 ;;=^5138296
 ;;^UTILITY(U,$J,358.3,1894,0)
 ;;=E10.3413^^16^126^55
 ;;^UTILITY(U,$J,358.3,1894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1894,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diab Rtnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1894,1,4,0)
 ;;=4^E10.3413
 ;;^UTILITY(U,$J,358.3,1894,2)
 ;;=^5138297
 ;;^UTILITY(U,$J,358.3,1895,0)
 ;;=E10.3491^^16^126^56
 ;;^UTILITY(U,$J,358.3,1895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1895,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diab Rtnop w/o Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1895,1,4,0)
 ;;=4^E10.3491
 ;;^UTILITY(U,$J,358.3,1895,2)
 ;;=^5138299
 ;;^UTILITY(U,$J,358.3,1896,0)
 ;;=E10.3492^^16^126^57
 ;;^UTILITY(U,$J,358.3,1896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1896,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diab Rtnop w/o Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1896,1,4,0)
 ;;=4^E10.3492
 ;;^UTILITY(U,$J,358.3,1896,2)
 ;;=^5138300
 ;;^UTILITY(U,$J,358.3,1897,0)
 ;;=E10.3493^^16^126^58
 ;;^UTILITY(U,$J,358.3,1897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1897,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diab Rtnop w/o Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1897,1,4,0)
 ;;=4^E10.3493
 ;;^UTILITY(U,$J,358.3,1897,2)
 ;;=^5138301
 ;;^UTILITY(U,$J,358.3,1898,0)
 ;;=E11.3211^^16^126^77
 ;;^UTILITY(U,$J,358.3,1898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1898,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mld Nonprlf Diab Retnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1898,1,4,0)
 ;;=4^E11.3211
 ;;^UTILITY(U,$J,358.3,1898,2)
 ;;=^5138331
 ;;^UTILITY(U,$J,358.3,1899,0)
 ;;=E11.3212^^16^126^78
 ;;^UTILITY(U,$J,358.3,1899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1899,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mld Nonprlf Diab Retnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1899,1,4,0)
 ;;=4^E11.3212
 ;;^UTILITY(U,$J,358.3,1899,2)
 ;;=^5138332
 ;;^UTILITY(U,$J,358.3,1900,0)
 ;;=E11.3213^^16^126^79
 ;;^UTILITY(U,$J,358.3,1900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1900,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mld Nonprlf Diab Retnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1900,1,4,0)
 ;;=4^E11.3213
 ;;^UTILITY(U,$J,358.3,1900,2)
 ;;=^5138333
 ;;^UTILITY(U,$J,358.3,1901,0)
 ;;=E11.3291^^16^126^80
 ;;^UTILITY(U,$J,358.3,1901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1901,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mld Nonprlf Diab Retnop w/o Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1901,1,4,0)
 ;;=4^E11.3291
 ;;^UTILITY(U,$J,358.3,1901,2)
 ;;=^5138335
 ;;^UTILITY(U,$J,358.3,1902,0)
 ;;=E11.3292^^16^126^81
 ;;^UTILITY(U,$J,358.3,1902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1902,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mld Nonprlf Diab Retnop w/o Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1902,1,4,0)
 ;;=4^E11.3292
 ;;^UTILITY(U,$J,358.3,1902,2)
 ;;=^5138336
 ;;^UTILITY(U,$J,358.3,1903,0)
 ;;=E11.3293^^16^126^82
 ;;^UTILITY(U,$J,358.3,1903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1903,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mld Nonprlf Diab Retnop w/o Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1903,1,4,0)
 ;;=4^E11.3293
 ;;^UTILITY(U,$J,358.3,1903,2)
 ;;=^5138337
 ;;^UTILITY(U,$J,358.3,1904,0)
 ;;=E11.3511^^16^126^93
 ;;^UTILITY(U,$J,358.3,1904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1904,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diab Rtnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1904,1,4,0)
 ;;=4^E11.3511
 ;;^UTILITY(U,$J,358.3,1904,2)
 ;;=^5138355
 ;;^UTILITY(U,$J,358.3,1905,0)
 ;;=E11.3512^^16^126^94
 ;;^UTILITY(U,$J,358.3,1905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1905,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diab Rtnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1905,1,4,0)
 ;;=4^E11.3512
 ;;^UTILITY(U,$J,358.3,1905,2)
 ;;=^5138356
 ;;^UTILITY(U,$J,358.3,1906,0)
 ;;=E11.3513^^16^126^95
 ;;^UTILITY(U,$J,358.3,1906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1906,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diab Rtnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1906,1,4,0)
 ;;=4^E11.3513
 ;;^UTILITY(U,$J,358.3,1906,2)
 ;;=^5138357
 ;;^UTILITY(U,$J,358.3,1907,0)
 ;;=E11.3591^^16^126^96
 ;;^UTILITY(U,$J,358.3,1907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1907,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diab Rtnop w/o Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1907,1,4,0)
 ;;=4^E11.3591
 ;;^UTILITY(U,$J,358.3,1907,2)
 ;;=^5138375
 ;;^UTILITY(U,$J,358.3,1908,0)
 ;;=E11.3592^^16^126^97
 ;;^UTILITY(U,$J,358.3,1908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1908,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diab Rtnop w/o Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1908,1,4,0)
 ;;=4^E11.3592
 ;;^UTILITY(U,$J,358.3,1908,2)
 ;;=^5138376
 ;;^UTILITY(U,$J,358.3,1909,0)
 ;;=E11.3593^^16^126^98
 ;;^UTILITY(U,$J,358.3,1909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1909,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diab Rtnop w/o Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1909,1,4,0)
 ;;=4^E11.3593
 ;;^UTILITY(U,$J,358.3,1909,2)
 ;;=^5138377
 ;;^UTILITY(U,$J,358.3,1910,0)
 ;;=E11.3411^^16^126^108
 ;;^UTILITY(U,$J,358.3,1910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1910,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diab Rtnop w/ Mac Edema,Rt Eye
 ;;^UTILITY(U,$J,358.3,1910,1,4,0)
 ;;=4^E11.3411
 ;;^UTILITY(U,$J,358.3,1910,2)
 ;;=^5138347
 ;;^UTILITY(U,$J,358.3,1911,0)
 ;;=E11.3412^^16^126^109
 ;;^UTILITY(U,$J,358.3,1911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1911,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diab Rtnop w/ Mac Edema,Lt Eye
 ;;^UTILITY(U,$J,358.3,1911,1,4,0)
 ;;=4^E11.3412
 ;;^UTILITY(U,$J,358.3,1911,2)
 ;;=^5138348
 ;;^UTILITY(U,$J,358.3,1912,0)
 ;;=E11.3413^^16^126^110
 ;;^UTILITY(U,$J,358.3,1912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1912,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diab Rtnop w/ Mac Edema,Bilateral
 ;;^UTILITY(U,$J,358.3,1912,1,4,0)
 ;;=4^E11.3413
 ;;^UTILITY(U,$J,358.3,1912,2)
 ;;=^5138349
