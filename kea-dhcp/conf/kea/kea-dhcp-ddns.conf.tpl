// This is a basic configuration for the Kea DHCP DDNS daemon.
//
// This is just a very basic configuration. Kea comes with large suite (over 30)
// of configuration examples and extensive Kea User's Guide. Please refer to
// those materials to get better understanding of what this software is able to
// do. Comments in this configuration file sometimes refer to sections for more
// details. These are section numbers in Kea User's Guide. The version matching
// your software should come with your Kea package, but it is also available
// in ISC's Knowledgebase (https://kb.isc.org/docs/kea-administrator-reference-manual; the direct link for
// the stable version is https://jenkins.isc.org/job/Kea_doc/guide/kea-guide.html).
//
// This configuration file contains only DHCP DDNS daemon's configuration.
// If configurations for other Kea services are also included in this file they
// are ignored by the DHCP DDNS daemon.
{

// DHCP DDNS configuration starts here. This is a very simple configuration
// that simply starts the DDNS daemon, but will not do anything useful.
// See Section 11 for examples and details description.
"DhcpDdns":
{
  "ip-address": "{{ key "/dhcpddns/ipaddress" }}",
  "port": {{ key "/dhcpddns/port" }},
  "tsig-keys": [],
  "forward-ddns" : {{ key "/dhcpddns/forward-ddns" }},
  "reverse-ddns" : {{ key "/dhcpddns/reverse-ddns" }}
},

// Logging configuration starts here. Kea uses different loggers to log various
// activities. For details (e.g. names of loggers), see Chapter 18.
"Logging":
{
  "loggers": [
    {
        // This specifies the logging for D2 (DHCP-DDNS) daemon.
        "name": {{ keyOrDefault "/dhcpddns/logger/name" "dhcpddns" }},
        "output_options": [
            {
                // Specifies the output file. There are several special values
                // supported:
                // - stdout (prints on standard output)
                // - stderr (prints on standard error)
                // - syslog (logs to syslog)
                // - syslog:name (logs to syslog using specified name)
                // Any other value is considered a name of a time
                "output": "{{ keyOrDefault "/dhcpddns/logger/output" "stdout" }}"
                // "output": "stdout"

                // This governs whether the log output is flushed to disk after
                // every write.
                // "flush": false,

                // This specifies the maximum size of the file before it is
                // rotated.
                // "maxsize": 1048576,

                // This specifies the maximum number of rotated files to keep.
                // "maxver": 8
            }
        ],
        // This specifies the severity of log messages to keep. Supported values
        // are: FATAL, ERROR, WARN, INFO, DEBUG
        "severity": "{{ keyOrDefault "/dhcpddns/logger/severity" "INFO" }}",

        // If DEBUG level is specified, this value is used. 0 is least verbose,
        // 99 is most verbose. Be cautious, Kea can generate lots and lots
        // of logs if told to do so.
        "debuglevel": {{ keyOrDefault "/dhcpddns/logger/debuglevel" "0" }}
    }
  ]
}
}
