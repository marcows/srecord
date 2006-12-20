#!/bin/sh
#
#	srecord - manipulate eprom load files
#	Copyright (C) 2000, 2006 Peter Miller
#
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program; if not, write to the Free Software
#	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.
#
# MANIFEST: Test the C-array functionality
#
here=`pwd`
if test $? -ne 0 ; then exit 2; fi
work=${TMP_DIR-/tmp}/$$

pass()
{
	cd $here
	rm -rf $work
	echo PASSED
	exit 0
}

fail()
{
	cd $here
	rm -rf $work
	echo 'FAILED test of the C-array functionality'
	exit 1
}

no_result()
{
	cd $here
	rm -rf $work
	echo 'NO RESULT for test of the C-array functionality'
	exit 2
}

trap "no_result" 1 2 3 15

bin=$here/${1-.}/bin
mkdir $work
if test $? -ne 0; then no_result; fi
cd $work
if test $? -ne 0; then no_result; fi

cat > test.in << 'fubar'
S00600004844521B
S12300005468652070726F626C656D206F63637572726564207768656E2074686572652009
S123002077617320612066696C746572207573656420696E206164646974696F6E20746F13
S1230040207468650A432D4172726179206F757470757420666F726D61742E2020497420FD
S1230060707574206578747261207374756666206F6E2074686520737461636B2C20616EE8
S12300806420736F20736F6D650A432D417272617920696E7374616E636520766172696101
S12300A0626C65732C207768696368206A7573742068617070656E656420746F20626520E2
S12300C07A65726F2C206A7573742068617070656E640A6E6F20746F206265207A65726F99
S11400E02C206D616B696E672061206D6573732E0AB7
S5030008F4
S9030000FC
fubar
if test $? -ne 0; then no_result; fi

cat > test.ok << 'fubar'
/* HDR */
const unsigned char eprom[] =
{
0x54, 0x68, 0x65, 0x20, 0x70, 0x72, 0x6F, 0x62, 0x6C, 0x65, 0x6D, 0x20, 0x6F,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0x65, 0x72, 0x20, 0x75, 0x73, 0x65, 0x64, 0x20, 0x69, 0x6E,
0x20, 0x61, 0x64, 0x64, 0x69, 0x74, 0x69, 0x6F, 0x6E, 0x20, 0x74, 0x6F, 0x20,
0x74, 0x68, 0x65, 0x0A, 0x43, 0x2D, 0x41, 0x72, 0x72, 0x61, 0x79, 0x20, 0x6F,
0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x66, 0x6F, 0x72, 0x6D, 0x61, 0x74, 0x2E,
0x20, 0x20, 0x49, 0x74, 0x20, 0x70, 0x75, 0x74, 0x20, 0x65, 0x78, 0x74, 0x72,
0x61, 0x20, 0x73, 0x74, 0x75, 0x66, 0x66, 0x20, 0x6F, 0x6E, 0x20, 0x74, 0x68,
0x65, 0x20, 0x73, 0x74, 0x61, 0x63, 0x6B, 0x2C, 0x20, 0x61, 0x6E, 0x64, 0x20,
0x73, 0x6F, 0x20, 0x73, 0x6F, 0x6D, 0x65, 0x0A, 0x43, 0x2D, 0x41, 0x72, 0x72,
0x61, 0x79, 0x20, 0x69, 0x6E, 0x73, 0x74, 0x61, 0x6E, 0x63, 0x65, 0x20, 0x76,
0x61, 0x72, 0x69, 0x61, 0x62, 0x6C, 0x65, 0x73, 0x2C, 0x20, 0x77, 0x68, 0x69,
0x63, 0x68, 0x20, 0x6A, 0x75, 0x73, 0x74, 0x20, 0x68, 0x61, 0x70, 0x70, 0x65,
0x6E, 0x65, 0x64, 0x20, 0x74, 0x6F, 0x20, 0x62, 0x65, 0x20, 0x7A, 0x65, 0x72,
0x6F, 0x2C, 0x20, 0x6A, 0x75, 0x73, 0x74, 0x20, 0x68, 0x61, 0x70, 0x70, 0x65,
0x6E, 0x64, 0x0A, 0x6E, 0x6F, 0x20, 0x74, 0x6F, 0x20, 0x62, 0x65, 0x20, 0x7A,
0x65, 0x72, 0x6F, 0x2C, 0x20, 0x6D, 0x61, 0x6B, 0x69, 0x6E, 0x67, 0x20, 0x61,
0x20, 0x6D, 0x65, 0x73, 0x73, 0x2E, 0x0A,
};
const unsigned long eprom_termination = 0x00000000;
const unsigned long eprom_start       = 0x00000000;
const unsigned long eprom_finish      = 0x000000F1;
const unsigned long eprom_length      = 0x000000F1;

#define EPROM_TERMINATION 0x00000000
#define EPROM_START       0x00000000
#define EPROM_FINISH      0x000000F1
#define EPROM_LENGTH      0x000000F1
fubar
if test $? -ne 0; then no_result; fi

$bin/srec_cat test.in -exclude 13 42 -o test.out -ca
if test $? -ne 0; then fail; fi

diff test.ok test.out
if test $? -ne 0; then fail; fi

#
# The things tested here, worked.
# No other guarantees are made.
#
pass
