#!/bin/bash
# Copyright 2015-2024 The Wazo Authors  (see the AUTHORS file)
# SPDX-License-Identifier: GPL-3.0-or-later
set -e

for category in asterisk wazo ; do
	filename="${category}.tar.bz2"
	filename_sum="${category}.tar.bz2.sha256sum"
	push_url="mirror.wazo.community:/data/sounds/${filename}"

	rm -f "${filename}"
	tar cjf "${filename}" "${category}"
	sha256sum "${filename}" > "${filename_sum}"
	scp "${filename}" "${push_url}"
done
