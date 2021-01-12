need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionMemoryConfiguration:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked  = False;
my      Bool                                        $analyzed       = False;
my      Lock                                        $lock           = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config        is required;
has     Bool                                        $.initialized   = False;
has     Str                                         $.ActiveMemoryExpansionEnabled          is conditional-initialization-attribute;
has     Str                                         $.ActiveMemorySharingEnabled            is conditional-initialization-attribute;
has     Str                                         $.DesiredMemory                         is conditional-initialization-attribute;
has     Str                                         $.ExpansionFactor                       is conditional-initialization-attribute;
has     Str                                         $.HardwarePageTableRatio                is conditional-initialization-attribute;
has     Str                                         $.MaximumMemory                         is conditional-initialization-attribute;
has     Str                                         $.MinimumMemory                         is conditional-initialization-attribute;
has     Str                                         $.CurrentExpansionFactor                is conditional-initialization-attribute;
has     Str                                         $.CurrentHardwarePageTableRatio         is conditional-initialization-attribute;
has     Str                                         $.CurrentHugePageCount                  is conditional-initialization-attribute;
has     Str                                         $.CurrentMaximumHugePageCount           is conditional-initialization-attribute;
has     Str                                         $.CurrentMaximumMemory                  is conditional-initialization-attribute;
has     Str                                         $.CurrentMemory                         is conditional-initialization-attribute;
has     Str                                         $.CurrentMinimumHugePageCount           is conditional-initialization-attribute;
has     Str                                         $.CurrentMinimumMemory                  is conditional-initialization-attribute;
has     Str                                         $.MemoryExpansionHardwareAccessEnabled  is conditional-initialization-attribute;
has     Str                                         $.MemoryEncryptionHardwareAccessEnabled is conditional-initialization-attribute;
has     Str                                         $.MemoryExpansionEnabled                is conditional-initialization-attribute;
has     Str                                         $.RedundantErrorPathReportingEnabled    is conditional-initialization-attribute;
has     Str                                         $.RuntimeHugePageCount                  is conditional-initialization-attribute;
has     Str                                         $.RuntimeMemory                         is conditional-initialization-attribute;
has     Str                                         $.RuntimeMinimumMemory                  is conditional-initialization-attribute;
has     Str                                         $.SharedMemoryEnabled                   is conditional-initialization-attribute;
has     Str                                         $.PhysicalPageTableRatio                is conditional-initialization-attribute;

method  xml-name-exceptions () { return set <Metadata>; }

submethod TWEAK {
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_SUBMETHOD>;
    my $proceed-with-name-check = False;
    my $proceed-with-analyze    = False;
    $lock.protect({
        if !$analyzed           { $proceed-with-analyze    = True; $analyzed      = True; }
        if !$names-checked      { $proceed-with-name-check = True; $names-checked = True; }
    });
    self.etl-node-name-check    if $proceed-with-name-check;
    self.init;
    self.analyze                if $proceed-with-analyze;
    self;
}

method init () {
    return self                             if $!initialized;
    self.config.diag.post:                  self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!ActiveMemoryExpansionEnabled          = self.etl-text(:TAG<ActiveMemoryExpansionEnabled>,             :$!xml) if self.attribute-is-accessed(self.^name, 'ActiveMemoryExpansionEnabled');
    $!ActiveMemorySharingEnabled            = self.etl-text(:TAG<ActiveMemorySharingEnabled>,               :$!xml) if self.attribute-is-accessed(self.^name, 'ActiveMemorySharingEnabled');
    $!DesiredMemory                         = self.etl-text(:TAG<DesiredMemory>,                            :$!xml) if self.attribute-is-accessed(self.^name, 'DesiredMemory');
    $!ExpansionFactor                       = self.etl-text(:TAG<ExpansionFactor>,                          :$!xml) if self.attribute-is-accessed(self.^name, 'ExpansionFactor');
    $!HardwarePageTableRatio                = self.etl-text(:TAG<HardwarePageTableRatio>,                   :$!xml) if self.attribute-is-accessed(self.^name, 'HardwarePageTableRatio');
    $!MaximumMemory                         = self.etl-text(:TAG<MaximumMemory>,                            :$!xml) if self.attribute-is-accessed(self.^name, 'MaximumMemory');
    $!MinimumMemory                         = self.etl-text(:TAG<MinimumMemory>,                            :$!xml) if self.attribute-is-accessed(self.^name, 'MinimumMemory');
    $!CurrentExpansionFactor                = self.etl-text(:TAG<CurrentExpansionFactor>,                   :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentExpansionFactor');
    $!CurrentHardwarePageTableRatio         = self.etl-text(:TAG<CurrentHardwarePageTableRatio>,            :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentHardwarePageTableRatio');
    $!CurrentHugePageCount                  = self.etl-text(:TAG<CurrentHugePageCount>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentHugePageCount');
    $!CurrentMaximumHugePageCount           = self.etl-text(:TAG<CurrentMaximumHugePageCount>,              :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMaximumHugePageCount');
    $!CurrentMaximumMemory                  = self.etl-text(:TAG<CurrentMaximumMemory>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMaximumMemory');
    $!CurrentMemory                         = self.etl-text(:TAG<CurrentMemory>,                            :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMemory');
    $!CurrentMinimumHugePageCount           = self.etl-text(:TAG<CurrentMinimumHugePageCount>,              :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMinimumHugePageCount');
    $!CurrentMinimumMemory                  = self.etl-text(:TAG<CurrentMinimumMemory>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'CurrentMinimumMemory');
    $!MemoryExpansionHardwareAccessEnabled  = self.etl-text(:TAG<MemoryExpansionHardwareAccessEnabled>,     :$!xml) if self.attribute-is-accessed(self.^name, 'MemoryExpansionHardwareAccessEnabled');
    $!MemoryEncryptionHardwareAccessEnabled = self.etl-text(:TAG<MemoryEncryptionHardwareAccessEnabled>,    :$!xml) if self.attribute-is-accessed(self.^name, 'MemoryEncryptionHardwareAccessEnabled');
    $!MemoryExpansionEnabled                = self.etl-text(:TAG<MemoryExpansionEnabled>,                   :$!xml) if self.attribute-is-accessed(self.^name, 'MemoryExpansionEnabled');
    $!RedundantErrorPathReportingEnabled    = self.etl-text(:TAG<RedundantErrorPathReportingEnabled>,       :$!xml) if self.attribute-is-accessed(self.^name, 'RedundantErrorPathReportingEnabled');
    $!RuntimeHugePageCount                  = self.etl-text(:TAG<RuntimeHugePageCount>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'RuntimeHugePageCount');
    $!RuntimeMemory                         = self.etl-text(:TAG<RuntimeMemory>,                            :$!xml) if self.attribute-is-accessed(self.^name, 'RuntimeMemory');
    $!RuntimeMinimumMemory                  = self.etl-text(:TAG<RuntimeMinimumMemory>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'RuntimeMinimumMemory');
    $!SharedMemoryEnabled                   = self.etl-text(:TAG<SharedMemoryEnabled>,                      :$!xml) if self.attribute-is-accessed(self.^name, 'SharedMemoryEnabled');
    $!PhysicalPageTableRatio                = self.etl-text(:TAG<PhysicalPageTableRatio>,                   :$!xml) if self.attribute-is-accessed(self.^name, 'PhysicalPageTableRatio');
    $!xml                                   = Nil;
    $!initialized                           = True;
    self;
}

=finish
