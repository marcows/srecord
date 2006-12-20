#!/bin/sh
#
#	srecord - manipulate eprom load files
#	Copyright (C) 1998, 1999, 2006 Peter Miller
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
# MANIFEST: Test the c-array format functionality
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
	echo 'FAILED test of the c-array format functionality'
	exit 1
}

no_result()
{
	cd $here
	rm -rf $work
	echo 'NO RESULT for test of the c-array format functionality'
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
S111000048656C6C6F2C20576F726C64210A7B
S5030001FB
S9030000FC
fubar
if test $? -ne 0; then no_result; fi

cat > test.ok << 'fubar'
/* HDR */
const unsigned char bogus[] =
{
0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x2C, 0x20, 0x57, 0x6F, 0x72, 0x6C, 0x64, 0x21,
0x0A,
};
const unsigned long bogus_termination = 0x00000000;
const unsigned long bogus_start       = 0x00000000;
const unsigned long bogus_finish      = 0x0000000E;
const unsigned long bogus_length      = 0x0000000E;

#define BOGUS_TERMINATION 0x00000000
#define BOGUS_START       0x00000000
#define BOGUS_FINISH      0x0000000E
#define BOGUS_LENGTH      0x0000000E
fubar
if test $? -ne 0; then no_result; fi

$bin/srec_cat test.in -o test.out -c-array bogus
if test $? -ne 0; then fail; fi

diff test.ok test.out
if test $? -ne 0; then fail; fi

#
# The things tested here, worked.
# No other guarantees are made.
#
pass
