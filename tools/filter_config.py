from __future__ import absolute_import, print_function, unicode_literals
import fileinput
import re
import sys

DOMAIN_MAPPING = lambda x: x.replace('.', '-') + '.wpdev'

DEFINE_ADJUST = {
    'DB_NAME': 'wordpress',
    'DB_USER': 'wordpress',
    'DB_PASSWORD': 'wordpress',
    'DOMAIN_CURRENT_SITE': DOMAIN_MAPPING('okfn.org'),
}


def process(line):

    for key, val in DEFINE_ADJUST.iteritems():
        line = re.sub(r"define\(\s*'%s'\s*,\s*'[^']*'\s*\)" % key,
                      "define('%s', '%s')" % (key, val),
                      line)

    if line.startswith('$wpe_all_domains=array'):
        for match in re.finditer(r"(\d+)\s*=>\s*'([^']*)'", line):

            line = line.replace(match.group(0),
                                "%s => '%s'" % (match.group(1),
                                                DOMAIN_MAPPING(match.group(2))))

    return line


def main():
    for line in fileinput.input():
        print(process(line.rstrip('\r\n')))

if __name__ == '__main__':
    main()
