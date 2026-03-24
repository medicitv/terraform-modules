# Terraform modules
Public Terraform Modules

### Tags and releases

When a new version of main is pushed, you'll have to make a new release targeting your last commit.
We respect semantic versionning as : v{major}.{minor}.{patch} (ex: v3.0.0)

If a breaking change is made in a new release, please make a major version bump. Otherwise, minor version is for 
any evolutions and patch for any fixes.

Here is the standard comment for a new release : 

```
Breaking changes :
None

Features & Fix :

- bucket_lambda : Bump lamdba module version
```


When a new release is made, a new tag is created pining this release. Test and approve this new tag before using.

When a new release is considered stable, you'll have to pin the major tag to the same commit of the latest release.

In your local env :

`git log --oneline` to show log history, check the hash commit linked to the last major version tag

`git tag -f v2` for exemple to update your local tag to point to the Head

`git push --force origin v2` to update remote tag
