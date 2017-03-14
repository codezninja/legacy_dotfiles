let JavaGetToOptional = '%s/public \(\S\+\) \(get.*\n\s\+return\) \(\S\+\);/public Optional<\1> \2 \3 == null ? Optional.empty() : Optional.ofNullable(\3);'
