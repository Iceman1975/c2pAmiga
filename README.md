# Fastest C2P for Amiga 500

I am currently implementing a Raycaster/2.5D engine for the Amiga 500. Initially I used the c2p https://github.com/Kalmalyzer/kalms-...p2x1_4_c5_bm.s from Kalms, which offers a reasonable performance. The conversion is 160*100 to 320*200 at 2*2 pixels, whereby the horizontal resolution is doubled by Copper. So I need an efficient algorithm for 2*1. I came across the following thread:
https://eab.abime.net/showthread.php?p=1520841


Here the data is prepared a little and a word is used for each colour. Basically, the solution is quite fast (even if not as fast as stated in the thread). This was the starting point for me to think about my own solution. The aim is to manage with one byte per colour and to use the blitter as intensively as possible. I am now quite satisfied with the result, which is why I would like to present it here.


The starting point is the chunky buffer, in which each colour is represented by one byte. However, the colour information is ‘stretched’. Example:


| Colour No. | binary code (streched) | 
|------------|------------------------|
| 1 | 0000 0011 |
| 2 | 0000 1100 |
| 3 | 0000 1111 | 
| 4 | Etc.      |



Furthermore, a,b,c,d= 2 bits

A long word then looks like this

a1b1c1d1 a2b2c2d2 a3b3c3d3 a4b4c4d4

where

a=target bitplane 3

b=target bitplane 2

c=target bitplane 1

d=target bitplane 0



This eliminates the need to double the bits.
There are now 3 blitter operations:

Blitter merge of a and b:

Source A:

a1b1c1d1 a2b2c2d2

Source B+Byte and Shift >>4

0000 a3b3c3d3 a4b4c4d4

C-Mask: #$F0F0

Result:

a1b1 a3b3 a2b2 a4b4

Now you can create bytes with another blit

Source A:

a1b1 a3b3 a2b2 a4b4

Source B+2 byte and shift <<6

b3 a2b2 a4b4

C-Mask: #$ CCCC

Result:

a1a2 a3 a4 x x x x x (x=not relevant)

The last step merges the bytes and writes them to the corresponding bitplane:

Source A:

a1a2 a3 a4 x x x x x (x=not relevant)

Source B+2 bytes and shift >>8

a21a22 a23 a24 x x x x x (x=not relevant)

C-Mask: #$ FF00

Result:

a1a2 a3 a4 a21a22 a23 a24

For bitplane 2, repeat steps 2 (with other shifts) and 3. For bitplane 1 and 0 then step 1 and again steps 2 and 3. 10 blits are therefore required in total. The size of the blits is also decisive. The chunky buffer is 16,000 bytes in size (160*100). Steps 1 and 2 only blit 8000 bytes (=4000 words), the last step only 4000 bytes (=2000 words). This results in the following calculation (see code for how I arrive at the blit sizes https://github.com/Iceman1975/c2pAmiga):


2* H*10*4*n

4* H*(W/4)*n

4*2*(H*10)*n

4*H*n*(30+(W/4)+2)

->

4*H*n *(32+W/4)

As I understand it, there must always be 6 cycles (A and B are activated, C is deactivated and is only used as a mask).
4*100*6*72= 172,800 cycles. 
An Amiga 500 has 141800 cycles per frame, so the conversion should be done in 2 frames.



| | Amiga 500 | Amiga 1200 |
|-|-----------|------------|
| 2*2 C2P Iceman | 25 FPS | 25 FPS |
| 2*2 C2P Kalms  | 13 FPS | 50 FPS |



[![amiga 500 raycaster](https://img.youtube.com/vi/mc_naAMR9A0/0.jpg)](https://www.youtube.com/watch?v=mc_naAMR9A0)

