﻿namespace CartService.DataAccess.Models;

public class BaseEntity
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
}
