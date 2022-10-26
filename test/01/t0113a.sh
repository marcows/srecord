#!/bin/sh
#
#       srecord - The "srecord" program.
#       Copyright (C) 2007, 2008, 2011 Peter Miller
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program. If not, see
#       <http://www.gnu.org/licenses/>.
#

TEST_SUBJECT="ti-txt"
. test_prelude.sh

cat > test.in << 'fubar'
S00600004844521B
S1050001656C28
S106000520576F0E
S104000A648D
S5030003F9
fubar
if test $? -ne 0; then no_result; fi

cat > test.ok << 'fubar'
@0001
65 6C
@0005
20 57 6F
@000A
64
q
fubar
if test $? -ne 0; then no_result; fi

srec_cat test.in -o test.out -ti-txt > LOG 2>&1
if test $? -ne 0; then
    cat LOG
    fail
fi

diff test.ok test.out
if test $? -ne 0; then fail; fi

#
# The things tested here, worked.
# No other guarantees are made.
#
pass
