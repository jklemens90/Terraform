data "aws_ami" "server_ami" {
    most_recent = true
    owners = ["ami-024c22d5868672534"]

    filter {
        name = "Microsoft Windows Server 2019"
    }
}