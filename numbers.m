% Person 8

T = '15:06:55.299';
infmt = 'hh:mm:ss.SSS';
dd = [2094.92
2110.94
2126.96
2143.02
2154.04
2170.04
2186.1
2322.24
2333.26
2349.26
2365.28
2621.52
2632.52
2648.54
2664.54

];



cc = [7
6
4
1
7
6
4
1
7
6
4
1
7
6
4
];

fours = find(cc == 7)

T2 = seconds(dd);

T3 = seconds(4560.36);

D = duration(T,'InputFormat',infmt)

bla_bla = D + T2;

bla_bla(fours)